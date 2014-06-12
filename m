From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jun 2014 09:22:21 +0200
Subject: [PATCH v2 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <CAL1qeaGKUGjSzriDGptR+h23+bS3ZWuStz6koPURCstkFbEjNA@mail.gmail.com>
References: <1402398708-10722-1-git-send-email-thierry.reding@gmail.com>
 <1402398708-10722-2-git-send-email-thierry.reding@gmail.com>
 <CAL1qeaGKUGjSzriDGptR+h23+bS3ZWuStz6koPURCstkFbEjNA@mail.gmail.com>
Message-ID: <20140612072220.GC17027@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 01:23:59PM -0700, Andrew Bresticker wrote:
> On Tue, Jun 10, 2014 at 4:11 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
[...]
> > +static int tegra_xusb_padctl_pinconf_group_set(struct pinctrl_dev *pinctrl,
> > +                                              unsigned int group,
> > +                                              unsigned long *configs,
> > +                                              unsigned int num_configs)
> > +{
> > +       struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
> > +       const struct tegra_xusb_padctl_lane *lane;
> > +       enum tegra_xusb_padctl_param param;
> > +       unsigned int i;
> > +       u32 value;
> > +
> > +       lane = &padctl->soc->lanes[group];
> > +
> > +       for (i = 0; i < num_configs; i++) {
> > +               param = TEGRA_XUSB_PADCTL_UNPACK_PARAM(configs[i]);
> > +               value = TEGRA_XUSB_PADCTL_UNPACK_VALUE(configs[i]);
> > +
> > +               switch (param) {
> > +               case TEGRA_XUSB_PADCTL_IDDQ:
> > +                       value = padctl_readl(padctl, lane->offset);
> 
> This overwrites the configuration value - probably want to use a
> separate variable for the register value.

Good catch, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140612/8e8deb93/attachment.sig>
