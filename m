From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Oct 2009 17:55:13 +0100
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <1255096942-10451-4-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
	<1255096942-10451-4-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <20091009165513.GA5902@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2009 at 03:02:20PM +0100, Alan Jenkins wrote:
> 	# Do we have FASTFPE?
> 	FASTFPE		:=arch/arm/fastfpe
> 	ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> 	FASTFPE_OBJ	:=$(FASTFPE)/
> 	endif
> 	fastfpe
> 
> We don't have FASTFPE.  If this code still exists out of tree, it can
> surely maintain its own Makefile and Kconfig entries.  Let's not confuse
> users by allowing them to select FASTFPE, and then silently not building
> it.

The code is not maintained anymore, but can just be slotted in (as per
the recent request on the mailing list.)  I'd rather not have the
hastle of maintaining fastfpe patches thank you.
