From: adam@baker-net.org.uk (Adam Baker)
Date: Sun, 7 Feb 2016 16:15:36 +0000
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <20160206231935.GA30734@jirafa.cyrius.com>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch> <20160206231935.GA30734@jirafa.cyrius.com>
Message-ID: <56B76DA8.3090500@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/16 23:19, Martin Michlmayr wrote:
> * Andrew Lunn <andrew@lunn.ch> [2016-02-06 19:34]:
>> Can you find an easily way to reproduce it? iperf, or scp a big file
>> etc.
>
> FWIW, we had a similar bug report in Debian recently:
> https://lists.debian.org/debian-arm/2016/01/msg00098.html
>
> Turning off TCP RX and TX offloading make it go away:
> https://lists.debian.org/debian-arm/2016/01/msg00100.html
>
> Hopefully Thomas can do a bisect.
>

I observed a similar issue when performing a large NFSv4 transfer with a 
kirkwood based server. Unfortunately I'd just jumped from 3.14 to 4.4 so 
I could do with a better starting point to bisect from.

It failed several times while transferring a 4GB file over NFS but is 
stable in normal use.

Regards

Adam
