From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 09:04:10 +0100
Subject: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
In-Reply-To: <30bf98f0-c893-d306-ab79-3ba741790919@gmail.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
 <30bf98f0-c893-d306-ab79-3ba741790919@gmail.com>
Message-ID: <1485504250.19754.22.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Do, 2017-01-26 at 15:51 -0800, Florian Fainelli wrote:
> On 01/26/2017 03:37 PM, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Few things with your submission:
> 
> - if you send more than one patch, a cover letter is a welcome to
> explain your changes

There actually is a cover letter.  The git-send-email "cccmd =
scripts/get_maintainer.pl" hook doesn't work for the cover letter though
because it isn't a patch.  I've hand-picked some people who
touched/reviewed the driver before to the git-send-email command line,
but everybody else got the patches only.

Anyone has a good solution for this btw?

> - try to provide commit messages for things that are not obvious (in
> fact, most maintainers actually request commit messages even for trivial
> things)

The driver is out of tree still, these are cleanups Ulf Hansson asked
for last time the driver was submitted.

Full set of patches:
  https://www.kraxel.org/cgit/linux/log/?h=bcm2837-sdhost-cleanup

Plan for upstream merge is to actually squash all the incremental
cleanups, but for now I kept them as separate changes.  I think this
makes it easier to spot mistakes and it'll also help in case there are
regressions b/c you can bisect things.

> - have not we switched to the iproc SDHCI driver, or is this for the
> other SDIO connected peripherals here?

The 2835 has two SD controllers: The Arasan SDHCI controller that we
currently use (iproc drives that one), and a custom SD controller.

This is a driver for the custom one.  Has better performance than the
sdhci controller (according to Eric Anholt).  For the rpi3 switching to
this driver has the additional advantage that we can use the iproc
driver driver to handle the wifi.

cheers,
  Gerd
