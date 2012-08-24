From: utx@penguin.cz (Stanislav Brabec)
Date: Sat, 25 Aug 2012 00:24:42 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
Message-ID: <5wcltd6jtqk3980vckk2af7m.1345847082013@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

metan wrote:
>And as far as I remeber there are some magic values needed for the >LCD in order not to have distorted picture (blurred, etc.) There is a >callibration program in the service menu that allows you to modify the >values stored in the flash.
>
>I remeber Stanislav did some research on that (CCing).

As far as I remember, there were two issues causing LCD problems:

- LCD phase setting from service menu. Incorrect value causes vertical blur or ghosts. Some operations (NAND cleanup) may reset these values. Fixing it in the service menu fixes the problem. I think that Linux does not touch these registers at all and even does not know how to handle LCD phase.

- Not touching brightness registers. It seems that the default (maximal value) of brightness causes a bit unstable brightness and flickering. To fix that, simply write lower value to brightness registers. (I think that kernel does not touch these registers during boot, just initialises the backlight control driver.)
