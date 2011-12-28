From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 27 Dec 2011 22:50:13 -0800
Subject: [PATCH v2 2/2] Input: tegra-kbc - add default chromeos map
In-Reply-To: <1325053170-6984-3-git-send-email-olof@lixom.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-3-git-send-email-olof@lixom.net>
Message-ID: <20111228065013.GB29273@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 10:19:30PM -0800, Olof Johansson wrote:
> This adds a simple way to specify the ChromeOS-specific keyboard map
> instead of the "standard" map that is used on other Tegra devices such
> as Harmony-with-keyboard and Seaboard.
> 
> I expect the number of different keyboard layouts to be quite limited,
> and not many should be added over time. So instead of encoding the layout
> in the device tree, with all the can of worms that entails w.r.t. agreeing
> on a suitable binding, just add a property to specify that this is the
> map to be used, and include it in the driver.
> 
> If, over time, the number of mappings increase, the binding can be
> updated to include a custom map as a new property, without having to
> worry about backwards compatibility on existing devices.
> 

I'd rather we did not make shortcuts and did the proper DT binding.
Samsung folks want the similar thing so making a generic DT keymap
parser and using it in the driver would be the best way.

Another option is to simply loading proper keymap by the early
userspace.

Thanks.

-- 
Dmitry
