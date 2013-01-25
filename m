From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Jan 2013 17:59:26 +0100
Subject: [PATCH 0/2] Improvement for pca953x drivers
Message-ID: <1359133168-14879-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

those two patches are the begining of the improvement work we have
spoken about earlier. I started with the two patches you sent.

I've just made a small fix to make it build on the 2nd patch so I keep
your autorship and signed-off.

For the second one, it didn't build too, but I made a more substantial
change on it by moving the setting of the irq to the map function. So
for this one, I took the authorship and remove your signed-off to not
make you responsible of my possible bug! :)

I've compiled and run it, but as I don't have support for the pca905
interrupt on my board, I can't say it didn't break anything. Maybe
this time again Maxime will be willing to test it.

For the remaining improvement related to the PWA and MMP #ifdef, I
hope to be able to work on it this week-end.

Regards

Gregory CLEMENT (1):
  gpio: pca953x: use simple irqdomain

Linus Walleij (1):
  gpio: pca953x: use managed resources

 drivers/gpio/gpio-pca953x.c |   97 ++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 61 deletions(-)

-- 
1.7.9.5
