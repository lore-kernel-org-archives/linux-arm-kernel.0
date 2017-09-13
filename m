From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Sep 2017 10:29:11 -0700
Subject: [PATCH v2 14/28] arm64/sve: Backend logic for setting the vector
 length
In-Reply-To: <1504198860-12951-15-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-15-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170913172911.3ca2h6cpju7etifi@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:00:46PM +0100, Dave P Martin wrote:
> This patch implements the core logic for changing a task's vector
> length on request from userspace.  This will be used by the ptrace
> and prctl frontends that are implemented in later patches.
> 
> The SVE architecture permits, but does not require, implementations
> to support vector lengths that are not a power of two.  To handle
> this, logic is added to check a requested vector length against a
> possibly sparse bitmap of available vector lengths at runtime, so
> that the best supported value can be chosen.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Alex Benn?e <alex.bennee@linaro.org>

Can this be merged with patch 20? It seems to add the PR_ definitions
which get actually used later when the prctl interface is added.

-- 
Catalin
