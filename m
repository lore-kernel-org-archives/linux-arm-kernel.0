From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2018 17:37:45 +0200
Subject: [GIT PULL] for-next updates for soc/fsl drivers for v4.20 take 2
In-Reply-To: <20181004164715.14646-1-leoyang.li@nxp.com>
References: <20181004164715.14646-1-leoyang.li@nxp.com>
Message-ID: <CAK8P3a3uM0_wO-wf7h+1UkUXUSTVtWSrmX_RLVzAC8e3LCuseg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 6:47 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi arm-soc maintainers,
>
> Please merge the following updates for next.
>
> PS.  One of the patches is depending on the last pull request for fixes to build
> https://patchwork.kernel.org/patch/10622883/
> I didn't include the fix patches directly in this pull request to prevent a
> complicated merge.  Please let me know if there is a more preferred approach
> to deal with dependencies between pull requests.

Sorry, I'd rather not pull it like this, because that would result in a
broken branch on my side that fails to build until it gets merged with
the other one.

I think the best way to handle this is for you to:

- start a branch on the afa86d264a7c commit that you already sent me
  for 4.20.
- merge the soc-fsl-fix-v4.19-2 branch that you sent me for 4.19 into
  that branch
- rebase all patches from tags/soc-fsl-next-v4.20-2 on top of the merge
- resend the pull request with the new branch

This will result in a bisectable (i.e. each commit builds and works) branch
that also merges cleanly with my fixes branch.

Generally speaking, every branch you send must work standalone,
and each commit in that branch can only depend on work that
comes earlier in that branch.

       Arnd
