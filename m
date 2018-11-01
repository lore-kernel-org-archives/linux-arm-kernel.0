From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 1 Nov 2018 14:54:04 +1100
Subject: [LKP] b179f0826c BUG: kernel hang in boot stage
In-Reply-To: <20181101011307.GW24195@shao2-debian>
References: <20181101011307.GW24195@shao2-debian>
Message-ID: <20181101145404.396c0973@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, 1 Nov 2018 09:13:07 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> commit b179f0826c6a13563c5ce0554c6da6748a1fa699
> Author:     Stephen Rothwell <sfr@canb.auug.org.au>
> AuthorDate: Mon Oct 29 16:55:21 2018 +1100
> Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
> CommitDate: Mon Oct 29 16:55:21 2018 +1100
> 
>     Add linux-next specific files for 20181029
>     
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> a3bbfc79c4  Merge branch 'akpm/master'
> b179f0826c  Add linux-next specific files for 20181029
> +------------------------------------------------+------------+---------------+
> |                                                | a3bbfc79c4 | next-20181029 |
> +------------------------------------------------+------------+---------------+
> | boot_successes                                 | 33         | 0             |
> | boot_failures                                  | 2          | 30            |
> | BUG:kernel_hang_in_boot_stage                  | 1          | 30            |
> | IP-Config:Auto-configuration_of_network_failed | 1          |               |
> +------------------------------------------------+------------+---------------+

That is really hard to believe given that the commit above only adds
documentation to the tree :-)

$ git log --stat -1 next-20181029
commit b179f0826c6a13563c5ce0554c6da6748a1fa699 (tag: next-20181029)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Oct 29 16:55:21 2018 +1100

    Add linux-next specific files for 20181029
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

 Next/SHA1s            |   292 +
 Next/Trees            |   294 +
 Next/merge.log        | 14253 ++++++++++++++++++++++++++++++++++++++++++++++++
 Next/quilt-import.log |     2 +
 localversion-next     |     1 +
 5 files changed, 14842 insertions(+)

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181101/19f1d019/attachment-0001.sig>
