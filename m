From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 11:41:50 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <1460565110-26341-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
Message-ID: <20160422104150.GD2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
> It is important to hibernate/resume on the same CPU, otherwise we may
> change the cpu order or restore a big cpu's register state on a little
> cpu.
> 
> We know cpu 0 is the cpu the firmware booted us on last time, refuse to
> hibernate if it has been hotplugged out. Follow x86's example by registering
> a pm notifier that is called before processes are frozen and devices are
> stopped.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

I think for the time being we should just go ahead with this patch (with
Lorenzo's suggestion for the commit log):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Subsequently we could look at what Mark suggested on using MPIDR to
hibernate/resume on CPU other than 0.

-- 
Catalin
