From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Feb 2017 15:47:31 -0800
Subject: [PATCH v2 1/6] arm64: dts: Add symlinks for cros-ec-keyboard and
 cros-ec-sbs
In-Reply-To: <20170210010521.78872-2-briannorris@chromium.org>
References: <20170210010521.78872-1-briannorris@chromium.org>
 <20170210010521.78872-2-briannorris@chromium.org>
Message-ID: <CAOesGMiim2WFfEAg-bJmWTwWn69=V_GuEg6AxsxPYMyzd3KFUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 9, 2017 at 5:05 PM, Brian Norris <briannorris@chromium.org> wrote:
> From: Douglas Anderson <dianders@chromium.org>
>
> We'd like to be able to use the cros-ec-keyboard.dtsi and
> cros-ec-sbs.dtsi snippets for arm64 devices.  Currently those files live
> in the arm/boot/dts directory.
>
> Let's follow the convention set by commit 8ee57b8182c4 ("ARM64: dts:
> vexpress: Use a symlink to vexpress-v2m-rs1.dtsi from arch=arm") and use
> a symlink.  Note that in this case we put the files in a new
> "include/common" directory since these snippets may need to be
> referenced by dts files in many different subdirectories.

I'd rather have something like this:

https://marc.info/?m=147547436324674&w=2

Instead of having everybody move things over. I.e. make it easy to
refer to the arm version from arm64 instead of creating a "common"
layer inbetween.


-Olof
