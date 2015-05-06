From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 11:55:58 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <5549EE97.3020801@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <5549B9CC.1040709@huawei.com> <20150506093022.GB31001@leverpostej>
 <5549EE97.3020801@huawei.com>
Message-ID: <20150506104856.GC707@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > I think that given that we know the UART is not quite a PL011 we should
> > add an additional compatible string just in case some difference crops
> > up later that is problematic.
> >
> > So we'd have something like:
> >
> > 	compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
> >
> > That way we can add any optimisations or workarounds later as required.
> I understand and thanks for your suggestion.
> 
> Can I do not do this work in this patch set? Because I got the
> information UART0 is PL011 compatible. Hisilicon uart engineer can do
> this work in the future, maybe for UART1/UART2.

I am not asking you to do any driver work for this -- the current driver
should ignore the "hisilicon,hi6220-uart" string and recognise
"arm,pl011".

I am only asking you to add the additional string to the DTS, and to
update the binding document to list the new string. That way if and when
we need the kernel to distinguish between a regular PL011 and the
hi6220-specific variant, the DTB does not need to be updated in order to
do so.

Is UART 0 different from UART1 and UART2?

Thanks,
Mark.
