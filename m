From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 00:13:39 +0000
Subject: [PATCH 00/15] new locomo driver
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
> Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
> drivers present in Linux kernel has some problems:
> 
>  * It uses custom bus instead of platform bus/mfd core.

I believe Greg wouldn't see that as a positive point.

Don't think that the platform bus _should_ always be used.  It shouldn't
(Greg has said he'd like to see the platform bus to be totally killed off.)
Instead, custom buses properly suited to the class of device in question
is much preferred, especially if it aids in...

>  * Device drivers are not well layered/separated.

... better layering or separation of drivers.

So, thinking that converting from a custom bus to a platform bus
definitely is /not/ a positive step forward.

(Why mfd was ever allowed to re-use the platform bus stuff is a separate
question not relevent to these patches.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
