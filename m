From: eliad@wizery.com (Eliad Peller)
Date: Wed, 11 Mar 2015 14:12:54 +0200
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <20150310173550.GT5264@atomide.com>
 <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
 <3439869.6umCuOq6SV@wuerfel>
 <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
Message-ID: <CAB3XZEfnZbZqH95suJ9n39aZRr8kxPdj2HZuWKMvQtYmXe3QEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 1:34 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> I think that patch [0] should not be needed since for external clocks,
> the IP providing the clocks should have its own clock driver and for
> internal clocks, a property should be used instead as you said.
>
>> If there is no external clock provider for this chip and the clocks
>> are provided by the device itself, then all we need is a clock-frequency
>> property in the device node.
>>
>
> Agreed, IIUC Luciano wanted to expose the internal clocks by
> registering in the common clock framework but if those clocks are not
> really accessible from outside the wlan chip, then I also think that a
> device node property should be used instead.
>
how should i describe multiple clock-frequency properties (there are 2
relevant clocks) in this case?

does something like the following makes sense?

wlcore: wlcore at 2 {
    ...
    refclock: refclock {
        compatible = "fixed-clock";
        #clock-cells = <0>;
        clock-frequency = <38400000>;
    };
}

Eliad.
