From: ethan@ethantuttle.com (Ethan Tuttle)
Date: Wed, 4 Sep 2013 21:14:23 -0700
Subject: [PATCH] net: mvneta: properly disable HW PHY polling and ensure
 adjust_link() works
In-Reply-To: <20130904163245.GI20552@1wt.eu>
References: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130904163245.GI20552@1wt.eu>
Message-ID: <CACzLR4uDQK2bkcEJQXLe805EfSA8=eF+YH-FTYovHA0q+8Y9NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just booted with the patch on my Mirabox.  Both interfaces work!
Thank you Thomas.

One remaining issue is that the interface which uBoot didn't configure
is still getting a random mac address:

mvneta d0070000.ethernet eth0: Using hardware mac address f0:ad:4e:01:dc:97
mvneta d0074000.ethernet eth1: Using random mac address d2:35:dd:c8:99:48

This is on 3.11 plus Thomas' patch, which includes the previous fix to
"read MAC address from hardware when available".  Perhaps that fix
isn't working with the phylib?

Thanks again,

Ethan

On Wed, Sep 4, 2013 at 9:32 AM, Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Thomas!
>
> On Wed, Sep 04, 2013 at 04:21:18PM +0200, Thomas Petazzoni wrote:
> > This commit fixes a long-standing bug that has been reported by many
> > users: on some Armada 370 platforms, only the network interface that
> > has been used in U-Boot to tftp the kernel works properly in
> > Linux. The other network interfaces can see a 'link up', but are
> > unable to transmit data. The reports were generally made on the Armada
> > 370-based Mirabox, but have also been given on the Armada 370-RD
> > board.
> (...)
> > This patch has been tested on Armada 370 Mirabox, and now both network
> > interfaces are usable after boot.
>
> Just as a complementary check, I can also confirm that the OpenBlocks
> AX3 continues to work fine after this change.
>
> Best regards!
> Willy
>
