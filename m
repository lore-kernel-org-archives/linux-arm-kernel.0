From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Jan 2010 12:00:26 +0000
Subject: [alsa-devel] [PATCHv2 05/10] ASoC: AC97: SMDK: Add wm9713
	machine driver
In-Reply-To: <1264571959-15115-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264571959-15115-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100128120020.GA19270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:59:19PM +0900, jassisinghbrar at gmail.com wrote:

> +	Headphone Playback Switch - On
> +	$ amixer cset numid=4 1
> +

Actually, one thing that really needs fixing here - these instructions
refer to the controls by number.  This is extremely fragile in the face
of any changes in the CODEC driver since the control numbering is worked
out at runtime and any change in the set of controls exported by the
device may change the result.  It is much better to refer to the
controls by name since the names are much less likely to change.  This
is also helpful for people using other UIs which don't display the
control names.
