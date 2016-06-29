From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed, 29 Jun 2016 16:42:32 +0200
Subject: [PATCH 1/4] brcmfmac: Add brcm,nvram_file_name dt property
In-Reply-To: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAOiHx=n6itfmvwYQh+jUSDNguQFkos=MzjkDWP=GsupdgvF6KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29 June 2016 at 16:04, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a brcm,nvram_file_name dt property to allow overruling the default
> nvram filename for sdio devices. The idea is that we can specify a
> board specific nvram file, e.g. brcmfmac43362-ap6210.txt for boards
> with an ap6210 wifi sdio module and ship this in linux-firmware, so
> that wifi will work out of the box, without requiring users to find
> and then manually install the right nvram file for their board.

Directly defining a filename doesn't seem like a good OS-agnostic
approach. Maybe an alternative would be to add a model-property to the
nodes (this is allowed) and make brcmfmac to request
"FWFILENAME-<model>" as firmware if set? That would leave it to the OS
on how the filename is set.


Regards
Jonas
