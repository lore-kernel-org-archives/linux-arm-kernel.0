From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Apr 2014 14:30:39 +0100
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <5343F42D.5090205@linaro.org>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk> <5343F42D.5090205@linaro.org>
Message-ID: <20140408133039.GH16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 09:05:49AM -0400, David Long wrote:
> Unfortunately copy_to_user_page() also needs a pointer to a vma struct  
> so, while it presumably provides the model to follow, it can't simply be  
> dropped in.

Well, isn't this code doing the same thing as ptrace?  It seems to want
to modify a page in userspace of another process to change instructions
that are going to be executed.  That's what ptrace does, and ptrace
already copes with all the issues there.

Given that we've already solved that problem, wouldn't it be a good idea
if the tracing code would stop trying to reinvent broken solutions to
problems we have already solved?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
