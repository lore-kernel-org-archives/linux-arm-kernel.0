From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jun 2013 18:32:38 +0100
Subject: [RFC 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130612173238.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:23:29AM -0700, Laura Abbott wrote:
> Other architectures define various set_memory functions to allow
> attributes to be changed (e.g. set_memory_x, set_memory_rw, etc.)
> Currently, these functions are missing on ARM. Define these in an
> appropriate manner for ARM.

Please ensure that these functions only accept arguments for the module
range; they will fail probably very noisily and destructively if they
encounter the section mappings which we use for the direct RAM mapping.
