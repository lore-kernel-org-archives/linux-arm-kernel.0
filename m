From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Oct 2014 23:54:56 +0100
Subject: [PATCH 3/6] ASoC: kirkwood: get rid of armada-370-db driver
In-Reply-To: <20141028223521.GL18557@sirena.org.uk>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
Message-ID: <20141028235456.7d68d53e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

On Tue, 28 Oct 2014 22:35:21 +0000, Mark Brown wrote:
> On Tue, Oct 28, 2014 at 05:08:41PM +0100, Thomas Petazzoni wrote:
> > Now that the Armada 370 DB audio complex is fully described in the
> > Device Tree using the simple-card DT binding, the armada-370-db audio
> > machine driver can be removed.
> 
> This is just removing support for the old binding which is
> incompatible...

Hum, I'm not sure to follow you here. In a subsequent patch, I change
the Armada 370 DB audio complex DT description to use the
simple-audio-card DT binding, which makes the Armada 370 DB audio
machine driver irrelevant.

Of course, this means that if someone uses an old Armada 370 DB Device
Tree with a new kernel, it will no longer. But I believe this is kind
of expected for this specific case: when we originally introduced the
Armada 370 DB audio support, we knew a proper DT binding to describe
sound complex was arriving, and therefore the Armada 370 DB audio
machine driver was only a temporary solution until the pure DT solution
was available.

Therefore, with the agreement of the mvebu maintainers, I'd like to be
allowed to break the DT backward compatibility here, and get rid of
this audio machine driver which would otherwise have no users left.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
