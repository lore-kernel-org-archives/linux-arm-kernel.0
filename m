From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Dec 2016 16:18:24 +0000
Subject: [PATCH 14/18] arm64: signal32: move ilp32 and aarch32 common
 code to separated file
In-Reply-To: <1477081997-4770-15-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-15-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20161205161823.GF14429@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:33:13PM +0300, Yury Norov wrote:
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Please add some description, even if it means copying the subject.

> ---
>  arch/arm64/include/asm/signal32.h        |   3 +
>  arch/arm64/include/asm/signal32_common.h |  27 +++++++
>  arch/arm64/kernel/Makefile               |   2 +-
>  arch/arm64/kernel/signal32.c             | 107 ------------------------
>  arch/arm64/kernel/signal32_common.c      | 135 +++++++++++++++++++++++++++++++
>  5 files changed, 166 insertions(+), 108 deletions(-)
>  create mode 100644 arch/arm64/include/asm/signal32_common.h
>  create mode 100644 arch/arm64/kernel/signal32_common.c

I wonder whether you can make such patches more readable by setting
"diff.renames" to "copy" in your gitconfig (unless it's set already and
Git cannot detect partial file code moving/copying).

-- 
Catalin
