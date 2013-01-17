From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 17 Jan 2013 17:43:02 +0100
Subject: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if
 not defined in dt
In-Reply-To: <loom.20130117T105358-639@post.gmane.org> (Michal Bachraty's
 message of "Thu, 17 Jan 2013 15:14:20 +0000 (UTC)")
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
 <loom.20130117T105358-639@post.gmane.org>
Message-ID: <87a9s7lq09.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Michal" == Michal Bachraty <michal.bachraty@gmail.com> writes:

Hi Michael,

 Michal> I made changes to cpsw driver two weeks ago, which add support
 Michal> for reading MAC address from CPU and also I posted it to
 Michal> review.  You can find patch here :
 Michal> https://patchwork.kernel.org/patch/1966481/ I will create
 Michal> updated patch next week, depended on reactions. Can you try
 Michal> that patch? I'll be glad to hear your opinion.

Thanks, I missed that patch. Functionality wise the patches do the same,
but I must say I find my patch cleaner, as it doesn't involve any new dt
bindings or access to the am33xx specific control module registers from
the cpsw driver.

The way I've handled it is similar to how it is done on atleast one
other arm subarchicture, see
arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()

-- 
Bye, Peter Korsgaard
