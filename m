From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 13:54:31 +0200
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
In-Reply-To: <20160531005808.GA7913@shlinux2>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
 <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
 <20160509181829.GA19687@rob-hp-laptop>
 <CAPDyKFq2=mqujFjvJSYxg2nVmK=OrBKLtFfb-ErNJO3Zr_LMVw@mail.gmail.com>
 <20160528033613.GA3291@shlinux2> <20160531005808.GA7913@shlinux2>
Message-ID: <574D7B77.4000606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 02:58 AM, Peter Chen wrote:
> On Sat, May 28, 2016 at 11:36:13AM +0800, Peter Chen wrote:
>> All, how we move on for this?
>>
>> 1. Using a generic driver to manage both mmc and USB (and further
>> subsystem), USB and further subsystem do not use pwrseq node in dts.
>> 2. USB creates the similar driver under drivers/usb for its own use. 
>>
>> Which one do you prefer, thanks.
>>
> 
> Hi Krzysztof Kozlowski,
> 
> I think option 1 may be better according to Rob and Ulf's comment.

Hi,

I like the option #1 as well. The generic driver should rely and parse
existing bindings like 'reset-gpios'. Still additional property (e.g.
"do-the-power-sequence") seems needed as we do not want to play with all
reset-gpios in DTB.

> Would you like going on your patch set? You can work on generic pwrseq
> driver, I will do USB stuffs based on generic pwrseq driver?

Great, that sounds good! I'll start the work.

Best regards,
Krzysztof
