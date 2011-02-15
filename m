From: dacohen@gmail.com (David Cohen)
Date: Tue, 15 Feb 2011 16:50:29 +0200
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
	dev_dbg()
In-Reply-To: <20110215144457.GD11199@n2100.arm.linux.org.uk>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<20110215142923.GC11199@n2100.arm.linux.org.uk>
	<AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
	<20110215144457.GD11199@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin=4z0o6=J9f-1mszvGrpaRMgCMk=Ckh5+9j6EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 4:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 04:36:26PM +0200, David Cohen wrote:
>> But pr_cont() would be wrong in case of DEBUG isn't set, isn't it?
>
> Yes. ?One other solution you could do is:
>
> ? ? ? ?char buf[80], *p = buf;
>
> ? ? ? ?buf[0] = '\0';
> ? ? ? ?for (i = 0; i < ARRAY_SIZE(err_msg); i++)
> ? ? ? ? ? ? ? ?if (stat & (1 << i))
> ? ? ? ? ? ? ? ? ? ? ? ?p += scnprintf(p, sizeof(buf) - (p - buf),
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?" %s", err_msg[i]);
>
> ? ? ? ?dev_dbg(obj->dev, "%s: da:%08x%s\n", __func__, da, buf);
>
> which means that you're then printing the entire string in one go -
> and there's no chance for another message to come in the middle of it.
>
> Note that I've placed the ' ' at the beginning of the format string so
> that we don't end up with useless trailing space in messages. ?Minor
> point but it's easy to do here.

That could be my choice.
I'm not planing to resend this patch, but how good/bad it sounds to
you to have dev_dbg_cont() for such situation?

Br,

David
