From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 27 Dec 2009 10:35:38 +0100
Subject: tree with htc dream support
In-Reply-To: <d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
References: <20091205221100.GA32522@elf.ucw.cz>
	<1260054737.23633.35.camel@desktop>
	<a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
	<d6200be20912112142r7bdf8f18o31edd4457aa64998@mail.gmail.com>
	<1260627482.20913.7.camel@desktop>
	<d6200be20912121434x1a247837w75c518ba20fe684f@mail.gmail.com>
	<20091213212504.GD5114@elf.ucw.cz>
	<d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
Message-ID: <20091227093537.GD11737@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > One more wish list item: many drivers are now available in
> > drivers/staging/dream, and are being slowly cleaned up. Would it be
> > possible to start using those for android-msm-2.6.32 tree?
> >
> > You'll need to reapply some stuff I had to remove (like wakelocks),
> > but it should be still better/less work long term to patch those back
> > in than maintaining separate copy. Diff should get much smaller...
> 
> I do plan to look at these, but I don't know when I'll get to it.

So... this switches qdsp5 code from private version to version in
staging. It actually boots.

It should be followed by git rm of around 12K lines of code from your
patch... (And yes, it actually boots; I tested camera, it worked).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

									Pavel
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 49f85b4..94623a4 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_MSM_ONCRPCROUTER) += smd_rpcrouter_device.o
 obj-$(CONFIG_MSM_ONCRPCROUTER) += smd_rpcrouter_servers.o
 obj-$(CONFIG_MSM_RPCSERVERS) += rpc_server_dog_keepalive.o
 obj-$(CONFIG_MSM_RPCSERVERS) += rpc_server_time_remote.o
-obj-$(CONFIG_MSM_ADSP) += qdsp5/
+obj-$(CONFIG_MSM_ADSP) += ../../../drivers/staging/dream/qdsp5/
 obj-$(CONFIG_MSM_HW3D) += hw3d.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
