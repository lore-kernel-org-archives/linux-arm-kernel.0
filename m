From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Wed, 25 Jul 2012 11:55:01 +0300
Subject: [alsa-devel] [PATCH 0/4] ASoC: fix saif record unwork issue
In-Reply-To: <20120725064440.GA30982@shlinux2.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
 <20120724192125.GF3099@opensource.wolfsonmicro.com>
 <500F838E.6050709@bluegiga.com>
 <20120725064440.GA30982@shlinux2.ap.freescale.net>
Message-ID: <500FB465.1080707@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2012 09:44 AM, Dong Aisheng wrote:
> I reproduced your issue.
> It seems the root cause is that you used the wrong device to record.
> The record device is 1.

That was the problem. I used wrong device. I tried to record without 
parameter -D.


> Can you try again with below command?
> arecord -D hw:0,1 -d 5 -f S16_LE -r 44100 -c 2 1.wav

This works fine. Thanks!


Lauri
