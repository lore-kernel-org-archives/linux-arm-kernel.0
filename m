From: jayachandran.chandrashekaran@broadcom.com (Jayachandran Chandrashekaran Nair)
Date: Fri, 19 Feb 2016 12:28:26 +0530
Subject: [PATCH 1/4] arm64: Broadcom Vulcan support
In-Reply-To: <20160217171616.GH32647@leverpostej>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
 <1455389195-31870-2-git-send-email-jchandra@broadcom.com>
 <20160217171616.GH32647@leverpostej>
Message-ID: <CAKc_7PXte5nmtFRv4cQXJSFuWtAWnrBazYQJAEejX8ifxXRaMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 10:46 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Sun, Feb 14, 2016 at 12:16:32AM +0530, Jayachandran C wrote:
>> From: Zi Shen Lim <zlim@broadcom.com>
>
>> +     compatible = "brcm,vulcan-eval", "brcm,vulcan";
>
> You use "brcm,vulcan" as the compatible string for both the platform and
> the CPU nodes. You need different strings.
>
>> +
>> +     memory {
>> +             device_type = "memory";
>> +             reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
>> +                   <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
>> +     };
>
>> +/memreserve/ 0x80000000 0x00010000;
>
> What is this for?

This seems to left over from the time we were using spin. Will take
it out. Thanks.

>> +
>> +/ {
>> +     model = "Broadcom Vulcan";
>> +     compatible = "brcm,vulcan";
>
> As above, it doesn't make sense to have the same compatible string for
> both the platform as a whole and the CPU.

Will fix this in v2.

>> +                     device_type = "cpu";
>> +                     compatible = "brcm,vulcan", "arm,armv8";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };

Thanks for the review.

JC.
