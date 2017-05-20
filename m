From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 20 May 2017 17:20:08 +0100
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <20170520022154.6766-1-kernel.development@povil.us>
References: <20170520022154.6766-1-kernel.development@povil.us>
Message-ID: <20170520172008.5a979e8a@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 May 2017 20:21:54 -0600
Sam Povilus <kernel.development@povil.us> wrote:

> The number of xilinx ps uart should be set by a kernel parameter instead of
> using a #define. This allows the user to set the number of xilinx ps uart
> using only kconfig and not modifying kernel source.
> 
> The ps uart is used in Xilnx Zynq chips usually in quantities maxing at
> two, but there may be other chips that use more in the future or that I
> don't know about. 

If it maxes at two then just set it to two. If in in future it maxes at
lots then when it's going to happen change the code to do dynamic
allocation and test it versus actual hardware. 

Otherwise you break some of the basic ideas of having one kernel for many
systems.

Alan
