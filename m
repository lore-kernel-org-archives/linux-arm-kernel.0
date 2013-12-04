From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 09:29:35 -0800
Subject: [PATCH v2] ARM: highbank: handle soft poweroff and reset key
 events
In-Reply-To: <1386176717-1023-1-git-send-email-robherring2@gmail.com>
References: <1386176717-1023-1-git-send-email-robherring2@gmail.com>
Message-ID: <20131204172935.GA29667@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:05:17AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Graceful reboot and poweroff via IPMI commands to the management
> processor don't work. Power and reset keys are events from the
> management processor which are generated via IPC messages. Passing
> the keys to userspace does not work as neither acpid nor a desktop
> environment are present.
> 
> This adds a notifier handler for the IPC messages so the kernel can
> handle the key events directly and IPMI graceful shutdown will work.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> v2: Re-word the commit msg to give better description of the issue.

Applied, and cc:d stable in the commit message. Thanks for rewording and
explaining why it's considered a bugfix.

-Olof
