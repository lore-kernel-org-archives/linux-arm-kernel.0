From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 3 Jun 2016 21:56:39 +0100
Subject: [PATCH 2/3] arm64: efi: Ensure efi_create_mapping() does not map
 overlapping regions
In-Reply-To: <20160602165621.GD24938@e104818-lin.cambridge.arm.com>
References: <1464707672-21882-1-git-send-email-catalin.marinas@arm.com>
 <1464707672-21882-3-git-send-email-catalin.marinas@arm.com>
 <20160602145246.GH2658@codeblueprint.co.uk>
 <20160602165621.GD24938@e104818-lin.cambridge.arm.com>
Message-ID: <20160603205639.GO2658@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Jun, at 05:56:21PM, Catalin Marinas wrote:
> 
> Ard to confirm but I think the reason is the relative offset between
> code and data regions that must be preserved. For example, on Juno I
> get:
> 
> [    0.000000] efi:   0x0009fff6e000-0x0009fffaefff [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] efi:   0x0009fffaf000-0x0009ffffefff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> 
> Since the code may assume relative loads from the data section, we need
> to preserve this offset (which doesn't seem 64KB aligned).

Yeah, figures. Could you mention this in the changelog or in a code
comment?
