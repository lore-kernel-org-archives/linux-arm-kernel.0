From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Oct 2013 17:13:14 +0100
Subject: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
In-Reply-To: <5262AEE8.5010505@gmail.com>
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
 <20131018162956.GE25034@n2100.arm.linux.org.uk> <52616B56.10407@gmail.com>
 <20131018175414.GF25034@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1310191059290.1951@syhkavp.arg> <5262AEE8.5010505@gmail.com>
Message-ID: <20131019161314.GK25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 19, 2013 at 06:10:16PM +0200, Daniel Mack wrote:
> Well, I totally see your point. However, we have machines out there that
> won't update via kexec due to this, and fixing kexec is unfortunately
> not an option, as updating anything would involve kexec'ing into an
> update kernel again. So out only chance is to fix up the dtb location in
> early boot code.
> 
> You might say my case is special, and you're most probably right. I see
> that trying to fix things is opening a can of worms.
> 
> So - no worries, we'll just keep that patch around locally as it 'works
> for me' (tm) :)

How about fixing kexec to work properly anyway, so that at a later date
you can drop that patch?
