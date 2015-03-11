From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 22:48:13 +0100
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <79FFFE06-191C-404D-8923-48C9C28C61F7@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <2155628.BceQuZbXC8@wuerfel>
 <79FFFE06-191C-404D-8923-48C9C28C61F7@codeaurora.org>
Message-ID: <7229476.C4So9noUlf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 15:35:22 Kumar Gala wrote:
> On Mar 11, 2015, at 3:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Wednesday 11 March 2015 08:33:04 Bjorn Andersson wrote:
> >> 
> >> But are these values actually used by the boot loader?
> >> 
> >> As far as I could see in 8974 the dtbTool provided by Qualcomm
> >> extracts the values from the list of dtbs and use them to create the
> >> table-of-content in the QCDT blob. The boot loader then looks in this
> >> TOC to pick the right dtb to use.
> >> 
> > 
> > I guess if I understand this right, we just need to fix that dtbTool
> > then to look at the top-level compatible property and/or machine
> > name instead?
> > 
> >       Arnd
> 
> Correct, and it means updating the tool for every board/dts that gets created in the future.
> 
> Thus, the feeling was that having the ids kept with the dtb made maintenance far easier.
> 

Part of my objection was to having nonstandard properties that are
not even used anywhere in the kernel. If you could just encode
them in the root compatible property as a string, that would be
a lot nicer.

	Arnd
