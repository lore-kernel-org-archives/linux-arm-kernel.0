From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 15:31:45 +0100
Subject: [PATCH] arm: get rid of hardcoded assumptions about kernel stack
 size
In-Reply-To: <1403099422-850-1-git-send-email-a.ryabinin@samsung.com>
References: <1403099422-850-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20140618143145.GH2186@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 02:50:22PM +0100, Andrey Ryabinin wrote:
> Changing kernel stack size on arm is not as simple as it should be:
> 1) THRED_SIZE macro doen't respect PAGE_SIZE and THREAD_SIZE_ORDER

THREAD_SIZE

> 2) stack size is hardcoded in get_thread_info macro
> 
> This patch fixes it by caculating THREAD_SIZE and thread_info address
> taking into account PAGE_SIZE and THREAD_SIZE_ORDER.
> 
> Now changing stack size becomes simply changing THREAD_SIZE_ORDER.

Curious: is this just a cleanup, or are you actually running out of kernel
stack on an ARM platform?

Will
