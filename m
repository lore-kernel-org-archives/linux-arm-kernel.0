From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 00:31:59 +0100
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <1346280600-29395-2-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
Message-ID: <20120829233159.GS18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 05:49:55PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation for mulit-platform support, convert all platforms' ARCH_
> definition to a hidden option and create a new choice option.

This is churn and annoyance.  It's definitely annoyance for the
autobuilder because it's going to have to have symbols changed in the
seed configs. It's annoyance for people because they're going to have
to manually reselect their SoC types in every build they do.

I think also that Kconfig will end up on 'make oldconfig' selecting
one of the platforms, deselecting all the dependencies on that platform,
which then means you'll have thousands of Kconfig options to answer.

I've been there with x86 configs, and spent something like an hour
piecing together a configuration for my laptop, answering one question
every couple of seconds.  That is not a nice experience to inflict on
people.
