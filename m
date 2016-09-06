From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Tue, 06 Sep 2016 08:27:49 +0300
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
Message-ID: <57ce53d6.0a28190a.3d6d2.44b2@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm testing the marvell-cesa -driver on Armada 385 board and I think I've found
a regression between Linux 4.7 and 4.8-rc4.
I want to accelerate my curl connections. So I compiled the 4.8-rc4 with
marvell-cesa enabled and HEAD revision of cryptodev-linux.

Here is my output:

~# uname -r
4.8.0-rc4
~# modprobe cryptodev
~# modprobe marvell-cesa
~# curl -k --ciphers AES256-SHA256 https://myserver/myfile >/dev/null
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
 19  200M   19 39.7M    0     0  16.2M      0  0:00:12  0:00:02  0:00:10 16.2M
curl: (56) SSL read: error:1408F119:SSL routines:SSL3_GET_RECORD:decryption
failed or bad record mac, errno 0

This error is quite easy to reproduce. Especially if you have some other
connections open at same time or two simultaneous curl-connections.
I had a ssh-connection running top(1).

I can not reproduce this with Linux 4.7 or without modprobing marvell-cesa.

I'm not using any special kernel parameter, patches, custom dts, etc.

Best Regards,
Jussi
