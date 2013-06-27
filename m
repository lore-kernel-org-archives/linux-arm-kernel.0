From: Larry.Finger@lwfinger.net (Larry Finger)
Date: Thu, 27 Jun 2013 09:45:32 -0500
Subject: RTL8192CU on ARM not working
In-Reply-To: <20130627081225.GJ5803@lukather>
References: <20130627081225.GJ5803@lukather>
Message-ID: <51CC500C.9050602@lwfinger.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2013 03:12 AM, Maxime Ripard wrote:
> Hi everyone,
>
> I'm currently trying to use a RTL8192CU on an ARM (Freescale imx28,
> armv5) platform, using 3.10-rc3.
>
> Trouble is, while the chip is correctly detected and you can use iw on it
> without any problem it seems, once you start an association to an access
> point, the association goes on, seems to associate, displaying a WARN()
> message [1] and then, after what looks like a random amount of time (could
> be right away, could be after a few minutes), deassociate [2].
>
> During the time where it's associated, we never seem to transmit any
> packets, while iw reports packets being sent, I guess we can assume that
> they are actually never transmitted as well [3].
>
> What seems odd to me as well is that the signal power reported for the access
> point is excessively high when using iw scan (10 dbm), and once connected, the
> signal strength is -64dbm, which makes quite a huge difference.

That warning is under discussion. See the thread entitled "rtl8192cu: slow path 
warning" in the linux-wireless ML. I will add you to the Cc list on those messages.

You should switch to kernel 3.10-rc7. There are a lot of changes to rtl8192cu in 
that version that are not in -rc3. Those updates mostly affect WPA and WEP 
encryption.

I never take signal power values seriously. Just observe the comments scattered 
throughout the code regarding them.

Larry
