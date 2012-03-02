From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 2 Mar 2012 03:52:17 -0700 (MST)
Subject: [PATCH-V3 2/3] ARM: OMAP4: prminst: Add boot time __init function
 for prminst
In-Reply-To: <1328269436-18668-3-git-send-email-hvaibhav@ti.com>
References: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
 <1328269436-18668-3-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1203020348460.15424@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 3 Feb 2012, Vaibhav Hiremath wrote:

> AM33xx PRM module is closer to OMAP4 PRM module, and
> in order to reuse prminst api's we have to address
> some of the differences like, base addresses and partitions.
> Unlike OMAP4 PRM, AM33xx doesn't have any partitions and
> maintains single partition.
> 
> So, in order to reuse the existing OMAP4 prminst code
> for AM33xx this patch adds,
> 
>   - Boot time __init function, to initialize _prm_bases
>     based on cpu_is_xxx
>   - Instead of maintaining phy addr for PRM partition
>     in _prm_bases[] table and then changing it to virt addr,
>     directly maintain respective virt addr.

So as was mentioned in another thread, the prminst code is really for 
cases where there are PRM registers split across multiple IP blocks.  So 
far this doesn't appear to the case with AM33xx.  A better approach is 
probably to create a prm33xx.c, as was done in the branch that was 
mentioned in my last message.

Another problem with this patch is that it causes a large number of 
warnings from sparse -- the type casts aren't right or are missing. Please 
make sure that your patches don't add any sparse warnings before posting.  
You can do this with 'make C=2' assuming that you have sparse installed.


- Paul
