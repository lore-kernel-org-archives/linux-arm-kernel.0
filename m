From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Mon, 17 Oct 2016 11:23:52 +0200
Subject: [PATCH 10/10] mm: replace access_process_vm() write parameter
 with gup_flags
In-Reply-To: <20161013002020.3062-11-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-11-lstoakes@gmail.com>
Message-ID: <20161017092352.GH30704@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 01:20:20AM +0100, Lorenzo Stoakes wrote:
> This patch removes the write parameter from access_process_vm() and replaces it
> with a gup_flags parameter as use of this function previously _implied_
> FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> 
> We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> (and hence bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/cris/arch-v32/kernel/ptrace.c |  4 ++--

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
