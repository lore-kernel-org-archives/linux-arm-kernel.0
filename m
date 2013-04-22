From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 18:49:05 +0100
Subject: [PATCH v1] ARM: do not select ARCH_VEXPRESS by default on
 ARCH_MULTI_V7
In-Reply-To: <1366634604-12637-1-git-send-email-srinivas.kandagatla@st.com>
References: <1366634604-12637-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130422174905.GT14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 01:43:24PM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch removes ARCH_VEXPRESS selection as default when ARCH_MULTI_V7
> is selected. ARCH_VEXPRESS should be selected from
> mach-vexpress/Kconfig.
> 
> Without this patch, any multiplatform build will have ARCH_VEXPRESS
> selected, as a result all the vexpress associated dtbs are build when we
> make dtbs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

There are reasons that this is done at the moment; Arnd has this under
control, and will remove this when stuff is ready to survive without
VEXPRESS enabled.
