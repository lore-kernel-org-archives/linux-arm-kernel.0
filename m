From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 16:55:06 +0100
Subject: [PATCH 1/9] arm64: Fix efi kernel entry
In-Reply-To: <873e73a998c198de69f6f01f92176be2b613c500.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <873e73a998c198de69f6f01f92176be2b613c500.1408736066.git.geoff@infradead.org>
Message-ID: <20140826155505.GG16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:49:15PM +0100, Geoff Levand wrote:
> The recent addition of EFI support has changed the way the arm64 kernel
> image is entered based on whether or not CONFIG_EFI is defined.  To support
> this conditional entry point add a new global symbol start to head.S that
> marks the entry, and change the the linker script ENTRY() command to define
> start as the kernel entry.

I don't yet understand what the problem is. The _text symbol is
currently defined in vmlinux.lds.S to be the beginning of the .head.text
section. Whether we have CONFIG_EFI or not, the entry point is the same.

-- 
Catalin
