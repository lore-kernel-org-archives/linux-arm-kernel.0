From: ccross@android.com (Colin Cross)
Date: Mon, 7 Mar 2011 11:59:02 -0800
Subject: [PATCH 0/3] Tegra i2c board changes + defconfig update
In-Reply-To: <1299486399-21761-1-git-send-email-olof@lixom.net>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
Message-ID: <AANLkTikxNgsE37t86VkLamzzt9W-E7jBTOTfXkqEvK9p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2011 at 12:26 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> Here is a short series of i2c patches to configure the i2c-tegra driver
> for the boards in the tree, and to register some of the devices.
>
> It also includes a defconfig update that enables the new drivers, enables
> TRIMSLICE by default since the pcie fix makes it possible and also turns
> on a few more config options that are useful (i.e. EFI partition tables
> and some common board devices).
>
> Since these patches rely on drivers that will be merged during the
> upcoming window, this is my plan:
>
> * Check them into boards-for-next together with Stephen W's
> ?other late-merge board patches in a day or two
> * Ask sfr to add said branch to linux-next (towards the end of list of trees)
> * Sit on them until merge window is open and base tegra, i2c and asoc have
> ?all been merged
> * Rebase to current upstream when said trees are in, let it sit for 1
> ?day for a linux-next cycle for sanity-check
> * Send pull request
>
>
> -Olof

Do we need two branches in linux-next?  I think we should just push
all of this to Tegra's for-next branch, and keep a for-linus branch
that points to the last change that will build without merging with
linux-next.  There shouldn't be any conflicts with linux-next, and
there is no need for linux-next to build after merging some of its
branches.
