From: alanbutty12@gmail.com (alan butler)
Date: Wed, 15 Aug 2012 22:23:29 +0100
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <20120815211517.GA15830@lunn.ch>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
 <20120815111209.GB22226@titan.lakedaemon.net>
 <CAMW5Ufb-8NrWu6vsJ+RezrLEGj-Wfm5Tc+0BK9_2qzn671FrpQ@mail.gmail.com>
 <20120815121145.GC22226@titan.lakedaemon.net>
 <CADhrpJ4-4n15yfttBBFQOdOkKag0gaeqYgB4DFre3aG+R4Vq+Q@mail.gmail.com>
 <20120815135427.GF22226@titan.lakedaemon.net>
 <CADhrpJ5JEGQWAjwu5+=Hy_gFjWLkkrzj9E0dZ-vxMk9x+M5uCA@mail.gmail.com>
 <20120815211517.GA15830@lunn.ch>
Message-ID: <CADhrpJ7+MoKF9qbeh9RBHo3j-m22574pi=cuHfQ9-KeVNX=mzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2012 22:15, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Alan
> ...
>
>> i did what you sujested and all commands worked except for the git
>> sendmail part so i do not know if I should still be sending you the
>> patch this way but here it is. i also defined the gpio keys in the dts
>> file like you said the same as with the iconnect but the kernel keeps
>> crashing with them defined in the dts is the support actualy there for
>> the keys? or have i just defined them wrong?
>
> ...
>
>> +             sata at 80000 {
>> +                     compatible = "marvell,orion-sata";
>> +                     reg = <0x80000 0x5000>;
>> +                     interrupts = <21>;
>> +                     status = "okay";
>> +                     nr-ports = <2>;
>> +             };
>
> You should not need all the values above. All you need is what is
> different to the defaults in kirkwood.dtsi. So i _think_ you need:
>
>                 sata at 80000 {
>                         status = "okay";
>                         nr-ports = <2>;
>                 };
>
>
>> +     gpio_keys {
>> +             compatible = "gpio-keys";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             button at 1 {
>> +                     label = "OTB Button";
>> +                     linux,code = <0x00>;
>
> 0x00 seems odd.
>
> From <linux/input.h>
>
> #define KEY_RESERVED            0
>
>
>> +                     gpios = <&gpio1 4 1>;
>> +                     debounce-interval = <100>;
>> +             };
>> +             button at 2 {
>> +                     label = "Reset";
>> +                     linux,code = <0x01>;
>
> 0x01 seems odd.
> #define KEY_ESC                 1
>
>> +                     gpios = <&gpio0 12 1>;
>> +                     debounce-interval = <100>;
>> +             };
>> +             button at 3 {
>> +                     label = "Power";
>> +                     linux,code = <0x028>;
>
> #define KEY_APOSTROPHE          40
>
> ???
>
>         Andrew

ah yeah the last key was a typo and the second key was just what was
in the origional file i was creating the patch from until i can get
the system to properly boot with the buttons defined in the dts file.
(was just kinda using those values as placeholders till i get the
kernel to boot with them then figure out the proper codes)

As for the sata definition that was just an experiment i forgot to
change back (wanted to see if it made any difference).
