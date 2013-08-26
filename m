From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 27 Aug 2013 00:19:00 +0530
Subject: [PATCH v6 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <20130826090422.GB7656@atomide.com>
References: <1377286330-29663-1-git-send-email-zonque@gmail.com>
 <1377286330-29663-3-git-send-email-zonque@gmail.com>
 <20130826090422.GB7656@atomide.com>
Message-ID: <521BA31C.1010504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 August 2013 02:34 PM, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [130823 12:39]:
>> At least the AM33xx SoC has a control module register to configure
>> details such as the hardware ethernet interface mode.
>>
>> I'm not sure whether all SoCs which feature the cpsw block have such a
>> register, so that third memory region is considered optional for now.
> Assuming you're talking about omap SCM registers here..
>
> This should be in a separate driver module so the control module
> parts can eventually be children of the SCM driver as they are
> really separate devices on the bus. See how the USB PHY parts were done
> for example.
>
> What do these control module registers do? If it's just multiplexing
> and pinconf, then you can use pinctrl-single,bits most likely for it and
> access it using the named modes.
>
> However, if the register also contains comparators and control for
> regulators, you should only use pinctrl-single for the multiplexing
> and pinconf parts.
>
I will take a look into usb control module driver and will try to adopt
the driver here also.

Regards
Mugunthan V N
