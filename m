From: dirk.behme@googlemail.com (Dirk Behme)
Date: Wed, 07 Apr 2010 18:24:39 +0200
Subject: [RFC PATCH v4 0/3] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
References: <1269879460-1038-1-git-send-email-imre.deak@nokia.com>
	<1270070606-5732-1-git-send-email-imre.deak@nokia.com>
Message-ID: <4BBCB1C7.4030407@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.03.2010 23:23, imre.deak at nokia.com wrote:
> Changes since v3:
> - Rebased against mainline v2.6.34-rc3, since some parts have already
>    been applied there.
>
> Note that this problem might affect more people than previously thought.
> The CodeSourcery 2009q1-203 glibc_ports has some NEON optimized functions;
> for example using memset or memcpy in a signal handler and floating point
> in the main thread can corrupt the main thread's context. You can test this
> by replacing the floating point ops in the signal handler below with some
> dummy memset/memcpy.
>
> I could only test these patches on a Cortex A8 UP system; it would be great
> if someone with an SMP board could give it a go. The test app to reproduce
> the problem (I've built it with -mfloat-abi=softfp -mfpu=neon):

Do you think this is relevant for ARM11 SMP (ARM11 MPCore), too? Or do 
you think this is necessary only for NEON systems, i.e. Cortex Ax?

Thanks and best regards

Dirk
