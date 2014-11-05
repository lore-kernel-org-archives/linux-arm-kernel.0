From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 5 Nov 2014 22:06:04 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141105203918.GA29199@amd>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd>
Message-ID: <201411052206.05379@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe you need to enable modem?

This is n900 init sequence from script: nokia-n900-configs.sh

    # set up the GPIO's for N900 modem:
    echo 70 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio70/direction
    echo 0 >/sys/class/gpio/gpio70/value
    echo 73 >/sys/class/gpio/export
    echo high >/sys/class/gpio/gpio73/direction
    echo 0 >/sys/class/gpio/gpio73/value
    echo 74 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio74/direction
    echo 75 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio75/direction
    echo 157 >/sys/class/gpio/export
    echo low >/sys/class/gpio/gpio157/direction
    echo 0 >/sys/class/gpio/gpio157/value
    # create symlinks for ofono N900 plugin
    mkdir -p /dev/cmt
    ln -nsf /sys/class/gpio/gpio70 /dev/cmt/cmt_apeslpx
    ln -nsf /sys/class/gpio/gpio74 /dev/cmt/cmt_en
    ln -nsf /sys/class/gpio/gpio73 /dev/cmt/cmt_rst_rq
    ln -nsf /sys/class/gpio/gpio75 /dev/cmt/cmt_rst
    ln -nsf /sys/class/gpio/gpio157 /dev/cmt/cmt_bsi

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/c8bb2e8d/attachment.sig>
