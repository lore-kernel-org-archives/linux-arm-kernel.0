From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 12:53:56 -0700
Subject: [GIT PULL] MCPM maintenance for v4.1
In-Reply-To: <alpine.LFD.2.11.1503251216310.27567@knanqh.ubzr>
References: <alpine.LFD.2.11.1503251216310.27567@knanqh.ubzr>
Message-ID: <20150403195356.GS23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 12:46:47PM -0400, Nicolas Pitre wrote:
> Please consider pulling the following:
> 
> http://git.linaro.org/people/nicolas.pitre/linux.git mcpm_for_armsoc
> 
> This series greatly simplifies things by moving all the locking handling 
> to the core code, leaving machine specific backend only with simple and 
> straight forward operations performed under lock protection. It will no 
> longer be necessary for backend authors to know about all the MCPM 
> subtleties for their code to be "right".
> 
> To avoid a flag day, the new scheme is introduced in parallel to the 
> existing backend interface. This series may be merged at the same time 
> as new backends still using the previous interface. That old interface 
> should be removed in a subsequent merge cycle after everything is 
> converted over.
> 
> The diffstat also shows a clear benefit.  Despite the addition of new 
> documentation and the previous interface still in place, the number of 
> lines actually goes down.
> 
> Tested on Versatile Express TC2 and Exynos 5800 (Chromebook2).

Hi,

This was based on a newer -rc than any other arm-soc contents (-rc4). I ended
up cherry-picking the patches over instead.

So, contents picked up but I didn't do it by merging the branch.


Thanks,

-Olof
