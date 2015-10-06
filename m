From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Oct 2015 12:33:28 +0100
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <mvmh9m48dpa.fsf@hawking.suse.de>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
 <20151006103128.GN6281@e103592.cambridge.arm.com>
 <5340366.WTVksOGb0G@wuerfel> <mvmh9m48dpa.fsf@hawking.suse.de>
Message-ID: <20151006113328.GP6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:59:45PM +0200, Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > I think it makes sense to stick with the traditional definition
> > of MINSIGSTKSZ == "the minimum amount that you will always need,
> > add whatever you require yourself" and SIGSTKSZ == "Should be
> > enough for a couple of function calls".
> 
> The python3 testsuite wants to put two signal frames in a SIGSTKSZ
> stack.

Whether it's valid to expect SIGSTKSZ to be big enough for that is
debatable.

But I guess that SIGSTKSZ = MINSIGSTKSZ * 4 provides some insurance
against such assumptions (doubtless the python testsuite is not
the only code affected).

Cheers
---Dave
