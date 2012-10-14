From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sun, 14 Oct 2012 20:56:11 +0100
Subject: [revert request for commit 9fff2fa] Re: [git pull] signals pile 3
In-Reply-To: <20121014192402.GZ2616@ZenIV.linux.org.uk>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com>
 <20121014164020.GV2616@ZenIV.linux.org.uk>
 <CACTFLAOpcLtHNx-TCHQkUOPNAkTO8EgDhbyZSGQ9ag+Wu_cNRw@mail.gmail.com>
 <20121014172640.GW2616@ZenIV.linux.org.uk>
 <20121014192402.GZ2616@ZenIV.linux.org.uk>
Message-ID: <20121014195611.GA2616@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2012 at 08:24:03PM +0100, Al Viro wrote:

> Russell, could you recall what those had been about?  I'm not sure if that
> had been oopsable that far back (again, oops scenario is userland stack
> page getting swapped out before we get to start_thread(), leading to
> direct read from an absent page in start_thread() by plain ldr, without
> anything in exception table about that insn), but it looks very odd
> regardless of that problem.

BTW, arm64 has copied that logics, so it also seems to be unsafe and very
odd - there we definitely have only ELF to cope with.  arm64 folks Cc'd...
