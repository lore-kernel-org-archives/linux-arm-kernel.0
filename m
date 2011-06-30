From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 11:07:55 +0100
Subject: Git pull request: 64-bit atomic user helper
In-Reply-To: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
References: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
Message-ID: <20110630100755.GU21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:54:07PM -0400, Nicolas Pitre wrote:
> Russell, please pull the following for the next merge window:
> 
> 	git://git.linaro.org/people/nico/linux.git cmpxchg64
> 
> This series cleans up the kuser documentation, then it adds 64-bit
> cmpxchg support as needed by some user space applications.
> 
> Tested with the initial libgcc patches relying on this, using a 
> kernel that has this series applied, and another without those 
> patches to verify that the test for the availability of the needed 
> helper does work as intended.
> 
> Nicolas Pitre (2):
>       ARM: kuser: move interface documentation out of the source code
>       ARM: add a kuser_cmpxchg64 user space helper
> 
>  Documentation/arm/kernel_user_helpers.txt |  267 +++++++++++++++++++++++
>  arch/arm/kernel/entry-armv.S              |  246 ++++++++-------------
>  2 files changed, 361 insertions(+), 152 deletions(-)

As these clash with the entry rework which I have, I'd much prefer
them to be in patch form rather than git form so I don't have to keep
remembering to fix the (broken) git rerere merge.  git rerere is fine
if you get it right first time but if not, then it keeps doing it wrong
each and every time.
