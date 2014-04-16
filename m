From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:31:45 +0100
Subject: [PATCH v7 3/7] ftrace: Add arm64 support to recordmcount
In-Reply-To: <1394862048-28758-4-git-send-email-takahiro.akashi@linaro.org>
References: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862048-28758-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416133145.GC1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:40:44AM +0000, AKASHI Takahiro wrote:
> Recordmcount utility under scripts is run, after compiling each object,
> to find out all the locations of calling _mcount() and put them into
> specific seciton named __mcount_loc.
> Then linker collects all such information into a table in the kernel image
> (between __start_mcount_loc and __stop_mcount_loc) for later use by ftrace.
> 
> This patch adds arm64 specific definitions to identify such locations.
> There are two types of implementation, C and Perl. On arm64, only C version
> is used to build the kernel now that CONFIG_HAVE_C_RECORDMCOUNT is on.
> But Perl version is also maintained.
> 
> This patch also contains a workaround just in case where a header file,
> elf.h, on host machine doesn't have definitions of EM_AARCH64 nor
> R_AARCH64_ABS64. Without them, compiling C version of recordmcount will
> fail.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
