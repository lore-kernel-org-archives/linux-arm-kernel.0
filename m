From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 18:43:20 +0100
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
In-Reply-To: <20130129174205.GD25646@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de> <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
 <20130128231829.6b205c3c@skate>
 <20130128222348.GA21628@obsidianresearch.com>
 <20130128233048.2ab6a6d2@skate>
 <20130128225105.GA21935@obsidianresearch.com>
 <20130129110119.07cb9ef3@skate>
 <20130129174205.GD25646@obsidianresearch.com>
Message-ID: <20130129184320.59f534c4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 29 Jan 2013 10:42:05 -0700, Jason Gunthorpe wrote:

> So if this is what you have now...
> 
> -[0000:00]-+-00.0 <- Host bridge
>            +-10.0 <- Bridge
>            +-11.0 <- Bridge
>            +-12.0 <- Bridge
> 
> Then removing the config space at 00.0 (ie the host bridge) will give
> you:
> 
> -[0000:00]-+-10.0 <- Bridge
>            +-11.0 <- Bridge
>            +-12.0 <- Bridge
> 
> The 'host bridge' isn't a bridge in the PCI-PCI sense, it is just a
> normal device at bus 0, device 0, function 0.

Ok, thanks I'll try this!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
