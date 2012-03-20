From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 20 Mar 2012 09:21:01 +0900
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <4F674479.8090101@gmail.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <20120319085503.GL15988@n2100.arm.linux.org.uk> <4F674479.8090101@gmail.com>
Message-ID: <005901cd062f$54ad5e50$fe081af0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote:


> On 03/19/2012 03:55 AM, Russell King - ARM Linux wrote:
> > On Mon, Mar 19, 2012 at 04:02:48PM +0900, Boojin Kim wrote:
> >> This patch uses LDRD/STRD that loads and stores data as DWORD unit
> >> for the copy of 8-words data.
> >> It brings better performance than LDRM/STRM that was used originally.
> >
> > And what about CPUs that don't have ldrd/strd ?
> >
>
> And what about CPUs that do have ldrd/strd but is slower than ldm/stm?
> I'm pretty sure that is almost everything currently out there.

Actually I didn't measure the memcpy performance on all ARM SoCs.
I just measured it with internal memcpy() benchmark on Cortex-A9 and Cortex-A15.
ldrd/strd is faster than ldm/stm on cortex-a15.
And it's similar on cortex-a9.
I will try again this patch gives meaningful effect to the targeted ARM SoCs

Thank you for your reply.
>
> Rob
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
