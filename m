From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Nov 2015 14:58:47 +0000
Subject: [PATCH 0/7] kvmtool: Cleanup kernel loading
In-Reply-To: <1446229620-28088-1-git-send-email-andre.przywara@arm.com>
References: <1446229620-28088-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20151102145846.GH29657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 06:26:53PM +0000, Andre Przywara wrote:
> Hi,

Hello Andre,

> this series cleans up kvmtool's kernel loading functionality a bit.
> It has been broken out of a previous series I sent [1] and contains
> just the cleanup and bug fix parts, which should be less controversial
> and thus easier to merge ;-)
> I will resend the pipe loading part later on as a separate series.
> 
> The first patch properly abstracts kernel loading to move
> responsibility into each architecture's code. It removes quite some
> ugly code from the generic kvm.c file.
> The later patches address the naive usage of read(2) to, well, read
> data from files. Doing this without coping with the subtleties of
> the UNIX read semantics (returning with less or none data read is not
> an error) can provoke hard to debug failures.
> So these patches make use of the existing and one new wrapper function
> to make sure we read everything we actually wanted to.
> The last patch moves the ARM kernel loading code into the proper
> location to be in line with the other architectures.
> 
> Please have a look and give some comments!

Looks good to me, but I'd like to see some comments from some mips/ppc/x86
people on the changes you're making over there.

Will
