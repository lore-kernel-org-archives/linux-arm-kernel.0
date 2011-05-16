From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 May 2011 16:31:49 -0400 (EDT)
Subject: [PATCHv2 00/15] Consolidate Orion platform information setup.
In-Reply-To: <1305459174-25517-1-git-send-email-andrew@lunn.ch>
References: <1305459174-25517-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.00.1105161608340.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 May 2011, Andrew Lunn wrote:

> This patchset consolidates some of the code used for creating
> platform data for various orion based SoC, namely Dove, Loki, Kirkwood,
> mv78xx0 and Orion5x. Where possible, this code has been put into the
> orion platform, with the mach-*/common.c calling the common platform
> code.
> 
> Additionally the setup of the multi purpose pins has been consolidated.
> Kirkwood and mv78xx0 had identical code, which has been generalized and
> put into the platform. Orion5x and Dove mpp code has been re-written to 
> use the consolidated method.
> 
> Tested on a Kirkwood device, otherwise compile tested.
> 
> Changes since last version:
> 
>  - Typos found by Saeed Bishara fixed
>  - All ethernets reserve the same size
>  - Add Kirkwood RTC interrupt as a seperate patch
>  - Rather than drop the dove mpp code, refactor to use the platform code.

This looks great. Thanks for this work. That will certainly make any 
transition to device tree much simpler.

Some further consolidation could be achieved by dynamically allocating 
the platform device structures as needed and having a single function 
for each class of devices.  But that can be done in a subsequent series.


Nicolas
