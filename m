From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 09 Jul 2015 21:08:36 +0300
Subject: [PATCH v2 0/7] KVM: arm/arm64: gsi routing support
In-Reply-To: <559EAB3D.2080205@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <023601d0ba54$c4d6e020$4e84a060$@samsung.com> <559E927E.8040403@arm.com>
 <026801d0ba5f$43a79520$caf6bf60$@samsung.com> <559EAB3D.2080205@linaro.org>
Message-ID: <028401d0ba72$4736dbc0$d5a49340$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Well personally I prefer the type thing and I don't see much difference
> at userspace level anyway. But I am not this kind of hyperspace
> architect guy. So, since there is no consensus here, I would say let's
> wait for formal reviews of our maintainers and I will align.

 Hah, okay... Don't take it for too much. Anyway your word weighs much more than my one...

> hope this eventually works with
> ITS ;-)

 You know... There are actually problems with irqfd. However i'm not sure whether they are result of
some bug or of poorly made vGIC CPU interface software emulation. I don't have hardware with working
vGICv3 here. With GICv2m everything is fine, but code path is quite different, and LPI != SPI.
 This is further overcomplicated by the fact that as soon as i start up the profiler, the problem
goes away. Looks like increased number of context switches have impact.
 Actually, the problem is very poor vhost-net throughput, which jumps up when i start the profiler
and goes back down when i stop it. Just to note...
 I'm off since now for a small vacation, will be back on monday or tuesday. See you guys!

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
