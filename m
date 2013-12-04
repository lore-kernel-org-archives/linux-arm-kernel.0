From: adrienverge@gmail.com (=?UTF-8?Q?Adrien_Verg=C3=A9?=)
Date: Wed, 4 Dec 2013 16:12:56 -0500
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <20131204170703.GA14859@kroah.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
Message-ID: <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/4 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> Your pid implementation is broken, see my other email about that :(

Thank you for your remarks on pid. I'll try to correct that.

> And again, what's wrong with the existing tracing functionalty that is
> processor agnostic?  Why can't we just delete this driver today and use
> the existing trace code?

As far as I know, the tracing functionality in
/sys/kernel/debug/tracing does not take advantage of ETM. ETM is a
dedicated hardware that greatly reduces tracing overhead. It only
exists on ARM platforms.

I understand using sysfs here is not the cleanest way. I patched my
kernel to meet my needs (trace a specific process or address range),
and I thought these small modifications could be useful -- until
bigger work is done to remove ETM control from sysfs.

Do you think it's worth correcting my patch (for pid namespaces) and
re-submitting it? Or should we wait for someone to port ETM tracing to
debugfs?

Thanks,

Adrien
