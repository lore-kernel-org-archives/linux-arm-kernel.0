From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 12:34:32 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140212102716.GE29702@arm.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com>
 <20140210164647.GB13533@sirena.org.uk>
 <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
 <20140211103428.GC8693@mudshark.cambridge.arm.com>
 <CAKfTPtDjF2bZsoj+tgBH-ZXYXNbXQ2mBie0FVgUy2vb_jY12FQ@mail.gmail.com>
 <20140211140749.GE3748@arm.com>
 <CAKfTPtATfnjP7R4ABSu_GDEYkVe3W6N2HU-ZkrQmT=nF31U4GA@mail.gmail.com>
 <20140212102716.GE29702@arm.com>
Message-ID: <20140212123432.GK28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:27:16AM +0000, Catalin Marinas wrote:
> On Wed, Feb 12, 2014 at 08:04:54AM +0000, Vincent Guittot wrote:

> > The fields will be used to construct topology so we must ensure their
> > visibility

> I wonder whether you need spinlocks around the topology updating code.

It certainly feels a lot safer to have them; if we can't convince
ourselves that the code is safe without them then there's very little
cost in having them so we may as well err on the side of doing that -
does that seem reasonable?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/a4dd9428/attachment.sig>
